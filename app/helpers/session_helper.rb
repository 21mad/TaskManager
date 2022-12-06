module SessionHelper
  def sign_in(user)
    cookies.signed[:user_id] = { value: user.id, expires: 7.days }
    # signed шифрует id пользователя, добавляем срок годности куки, чтобы пользователя не выкидывало во время сессии
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.signed[:user_id] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
    # ||= <=> @current_user = User.find if @current_user.nil?
  end
end
