module TokenAuth
  def authenticate!
    unauthorized unless current_user
  end

  def authorization_header
    @authorization_header ||= request.headers['Authorization']
  end

  def current_user
    return unless authorization_header

    active_line =
      AuthenticationLine
      .where(code: authorization_header, active: true)
      .where('active_until > ?', Time.current)
      .first

    return unless active_line

    @current_user ||= active_line.user
  end

  def render_errors(message: nil, errors: {}, status: :unprocessable_entity, result_code: :error)
    response = {
      message:,
      errors:,
      result_code:
    }

    render json: response, status:
  end

  def unauthorized(message: 'Unauthorized. Check your credentials.', result_code: :unauthorized, status: :unauthorized)
    render_errors(message:, result_code:, status:)
  end
end
