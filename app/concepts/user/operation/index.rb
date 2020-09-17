module User::Operation
  class Index < Trailblazer::Operation
    # step keyword
    step :valid_user?
    fail :log_error, fail_fast: true
    step :valid_role?
    fail :log_invalid_role_error
    step :load_data
    
    # fail_fast: true will terminal execution work like a break
    # ctx (context) global hash , ** many arguments
    def load_data(ctx, **)
      ctx[:users] = User.all
      ctx[:welcome] = 'Welcome to TRB training'
    end

    def valid_user?(ctx, **)
      false
    end

    def log_error(ctx, **)
      ctx[:error] = 'Unathorized User'
    end

    def valid_role?(ctx, **)
      true
    end

    def log_invalid_role_error(ctx, **)
      ctx[:invalid_role] = 'Invalid Role'
    end
  end
end