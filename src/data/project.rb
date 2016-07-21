require_relative 'base_class_for_data_classes'

class Project < BaseClassForDataClasses
  attr_accessor :account_id,
                :atom_enabled,
                :automatic_planning,
                :bugs_and_chores_are_estimatable,
                :created_at,
                :current_iteration_number,
                :description,
                :enable_following,
                :enable_incoming_emails,
                :enable_tasks,
                :has_google_domain,
                :id,
                :initial_velocity,
                :iteration_length,
                :kind,
                :name,
                :number_of_done_iterations_to_show,
                :point_scale,
                :point_scale_is_custom,
                :profile_content,
                :project_type,
                :public,
                :start_date,
                :start_time,
                :time_zone,
                :updated_at,
                :velocity_averaged_over,
                :version,
                :week_start_day

  def initialize(values = {})
    super(values)
  end

end