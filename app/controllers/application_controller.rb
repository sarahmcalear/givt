class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.

  # protect_from_forgery with: :exception

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  acts_as_token_authentication_handler_for User

  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    user = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    end
  end

  after_filter do
    resource = controller_path.singularize.gsub(/api\/v[\d]+\//i, '').gsub('/', '_')
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # Enable CanCan authorization by default
  check_authorization unless: :devise_controller?
end
