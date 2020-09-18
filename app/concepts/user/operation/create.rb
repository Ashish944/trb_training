module User::Operation
  class Create < Trailblazer::Operation
    step :check_email?, fail_fast: true
    fail :log_error_for_email
    step :check_password
    fail :log_error_invalid_password
    # pass :check_count
    step :role_present?, Output(:failure) => Id(:failure_role)
    step :success_role
    fail :failure_role
    # step :create_user#, pass_fast: true

    pass ->(ctx, **) { ctx[:message] = 'Lambda Operation' }

    def check_email?(ctx, **)
      ctx[:params][:email].present?  
    end

    def check_password(ctx, **)
      ctx[:params][:password] == ctx[:params][:password_confirmation]
    end

    def log_error_for_email(ctx, **)
      ctx[:email] = "Email can't be blank"
    end

    def log_error_invalid_password(ctx, **)
      ctx[:password] = 'confirm password is incorrect'
    end

    def create_user(ctx, **)
      User.create(ctx[:params])
    end

    def check_count(ctx, **)
      ctx[:response] = "User count - #{Use.count}"
      true
    end

    def role_present?(ctx, params:, **)
      params[:role].present?
    end

    def success_role(ctx, **)
      ctx[:role_success] = {
        message: 'Role Present'
      }
    end

    def success_role(ctx, **)
      ctx[:role_success] = {
        message: 'Role Not Present'
      }
    end
  end
end