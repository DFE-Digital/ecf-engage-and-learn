# frozen_string_literal: true

module RegisterAndPartnerApi
  class SyncUsers
    USER_TYPES = {
      ect: "early_career_teacher",
      mentor: "mentor",
    }.freeze

    CIP_TYPES = {
      ambition: "ambition",
      edt: "edt",
      teach_first: "teach_first",
      ucl: "ucl",
      none: "none",
    }.freeze

    def self.perform(all: false)
      new_sync_time = Time.zone.now - 1.minute
      last_sync = SyncUsersTimer.last_sync
      base_query = all ? {} : { filter: { updated_since: last_sync } }

      perform_pagination(base_query)

      SyncUsersTimer.set_last_sync(new_sync_time)
    rescue StandardError => e
      Rails.logger.warn("Failed to sync users: #{e}")
    end

    def self.perform_pagination(base_query)
      is_last_page = false
      page_number = 0
      all_user_ids = []
      until is_last_page
        page_number += 1
        paginated_query = base_query.merge(page: { page: page_number, per_page: 100 })

        response = RegisterAndPartnerApi::User.where(paginated_query).to_a
        new_user_ids = sync_users(response)

        only_repeated_users = response.count.positive? && (new_user_ids - all_user_ids).empty?
        Rails.logger.warn("No new users found on new page in user sync, stopping!") if only_repeated_users

        is_last_page = response.count.zero? || only_repeated_users
        all_user_ids += new_user_ids
        sleep(1) unless Rails.env.test?
      end
    end

    def self.sync_users(users)
      user_ids = []
      logger = Rails.logger
      users.each do |remote_user|
        attributes = user_attributes_from(remote_user)
        user_ids << attributes[:register_and_partner_id]

        case attributes[:user_type]
        when USER_TYPES[:ect]
          find_or_create_user(attributes, ::EarlyCareerTeacherProfile)
        when USER_TYPES[:mentor]
          find_or_create_user(attributes, ::MentorProfile)
        end

      rescue StandardError
        logger.warn("Error saving user!")
      end
      user_ids
    end

    def self.user_attributes_from(user_from_api)
      {
        register_and_partner_id: user_from_api.attributes[:id],
        full_name: user_from_api.attributes[:attributes][:full_name],
        email: user_from_api.attributes[:attributes][:email],
        user_type: user_from_api.attributes[:attributes][:user_type],
        cip: user_from_api.attributes[:attributes][:core_induction_programme],
        induction_programme_choice: user_from_api.attributes[:attributes][:induction_programme_choice],
        registration_completed: user_from_api.attributes[:attributes][:registration_completed],
      }
    end

    def self.find_or_create_user(attributes, profile_class)
      user = ::User.find_or_initialize_by(register_and_partner_id: attributes[:register_and_partner_id])
      needs_inviting = !user.persisted?
      save_user(attributes, user, profile_class)

      if needs_inviting && user.is_on_core_induction_programme?
        InviteParticipants.run([user.email])
      end
    end

    def self.save_user(attributes, user, profile_class)
      profile = profile_class.find_or_initialize_by(user: user)
      user.email = attributes[:email]
      user.full_name = attributes[:full_name]
      user.save!
      profile.core_induction_programme = get_core_induction_programme(attributes)
      profile.induction_programme_choice = attributes[:induction_programme_choice]
      profile.registration_completed = attributes[:registration_completed]
      profile.save!
    end

    def self.get_core_induction_programme(attributes)
      name = case attributes[:cip]
             when CIP_TYPES[:ambition]
               "Ambition Institute"
             when CIP_TYPES[:edt]
               "Education Development Trust"
             when CIP_TYPES[:teach_first]
               "Teach First"
             when CIP_TYPES[:ucl]
               "UCL"
             end
      CoreInductionProgramme.find_by(name: name)
    end

    private_class_method :sync_users, :user_attributes_from, :find_or_create_user, :save_user, :get_core_induction_programme
  end
end
