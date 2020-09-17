module User::Operation
  class Create < Trailblazer::Operation
    step :check_email?
    fail :log_error_for_email
    step :check_password
    fail :log_error_invalid_password
    step :create_user

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
  end
end