# frozen_string_literal: true

class CoreInductionProgramme::ModulesController < ApplicationController
  include Pundit
  include GovspeakHelper

  after_action :verify_authorized, except: :show
  before_action :authenticate_user!, except: :show
  before_action :load_course_module

  def show; end

  def edit; end

  def update
    if params[:commit] == "Save changes"
      @course_module.save!
      flash[:success] = "Your changes have been saved"
      redirect_to cip_year_module_url
    else
      render action: "edit"
    end
  end

private

  def load_course_module
    @course_module = CourseModule.find(params[:id])
    authorize @course_module
    @course_module.assign_attributes(course_module_params)
  end

  def course_module_params
    params.permit(:content, :title)
  end
end
