module TokenAuth
  def authenticate!
    unauthorized unless current_user
  end

  def authorization_header
    @authorization_header ||= request.headers['Authorization']
  end

  def current_user
    return unless authorization_header

    active_line = AuthenticationLine.where(code: authorization_header, active: true).where('active_until > ?', Time.current).first

    return unless active_line

    @current_user ||= active_line.user
  end

  def render_errors(message: nil, errors: {}, status: :unprocessable_entity, result_code: :error)
    response = {}

    response[:message] = message
    response[:errors] = errors
    response[:result_code] = result_code

    render json: response, status: status
  end

  def unauthorized(message: 'Unauthorized. Check your credentials.', result_code: :unauthorized, status: :unauthorized)
    render_errors(message: message, result_code: result_code, status: status)
  end
end
