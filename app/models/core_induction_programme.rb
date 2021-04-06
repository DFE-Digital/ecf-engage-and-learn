# frozen_string_literal: true

class CoreInductionProgramme < ApplicationRecord
  has_many :course_years, dependent: :delete_all
  belongs_to :course_year_one, class_name: "CourseYear", optional: true
  belongs_to :course_year_two, class_name: "CourseYear", optional: true
  has_many :early_career_teacher_profiles
  has_many :early_career_teachers, through: :early_career_teacher_profiles, source: :user
end
