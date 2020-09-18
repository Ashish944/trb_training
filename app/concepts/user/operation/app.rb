module User::Operation
  class App < Trailblazer::Operation
    step :get_user
    step :from_web, Output(:failure) => Id(:order_by_created_at)
    step :filter_interval
    step :filter_status
    step :set_web_response, pass_fast: true
    step :order_by_created_at
    step :set_mobile_response
  
    def get_user(ctx, **)
      @user = User.first
      true
    end

    def from_web(ctx, params:, **)
      params[:request].present? && params[:request] == 'Web'
    end
  
    def filter_interval(ctx, **)
      ctx[:message] = 'Filter Interval'
    end
  
    def filter_status(ctx, **)
      ctx[:message] = 'Filter Status'
    end
  
    def set_web_response(ctx, **)
      ctx[:response] = 'Web Response'
    end

    def order_by_created_at(ctx, **)
      ctx[:message] = 'Order desc created at'
    end

    def set_mobile_response(ctx, **)
      ctx[:response] = 'Mobile Response'
    end
  end
end