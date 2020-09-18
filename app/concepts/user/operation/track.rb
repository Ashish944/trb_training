class User::Operation::Track < Trailblazer::Operation

  step :is_admin?, Output(:failure) => Track(:member)
  step :admin_response
  step :second_admin_response
  step :member_response, magnetic_to: :member

  def is_admin?(ctx, params:, **)
    params[:role] == 'Admin'
  end

  def admin_response(ctx, **)
    ctx[:response] = {
      message_1: 'Admin'
    }
  end

  def second_admin_response(ctx, **)
    ctx[:response] = {
      message_2: 'Admin Second'
    }
  end

  def member_response(ctx, **)
    ctx[:response] = {
      message_3: 'Member'
    }
  end
end