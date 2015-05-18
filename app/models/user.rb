class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [ :github ]

  def self.from_github( auth )
    where( github_uid: auth.uid ).first_or_create do |user|
      user.github_token = auth.credentials.token
      user.github_email = auth.info.email
      user.github_login = auth.info.nickname
    end
  end

end
