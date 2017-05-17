class User < ApplicationRecord
  has_many :questions, dependent: :nullify
  has_many :likes, dependent: :destroy #if user is destroyed delete their likes

                                      #table name   on the reference questions
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

# If you’re in the form and you have a custom field showing undefined attribute, can add in attribute accessor user.rb

# If you add an attribute accessor to an ActiveRecord object then you will be able to capture that from the form and have it in memory but not stored in db if you don’t have a db field for it

# attr_accessor :abc

# we don't have to do this for `password` and `password_confirmation` if we use
# `f.password_field` because Rails automatically adds attribute accessors
# for these 2 special fields

  # before_validation :generate_password_digest
  # end



  # has_secure_password is a built-in Rails method that helps us with user
    # authentication.
    # 1. It will automatically add a presence validator for the password field
    # 2. When given a password it will generate a salt then it will hash the salt
    #    and password combo and will store the result of the Hashing (using
    #    bcrypt) along with the randomly generated salt into a database field
    #    called `password_digest`
    # 3. If you skip `password_confirmation` field then it won't give you a
    #    a validation errors for that. If you provide `password_confirmation` then
    #    it will validate that the password matches the password_confirmation
    # 4. We will get a method called `authenticate` that will help us test if the
    #    user has entered the correct password or not.
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :uid, uniqueness: { scope: :provider }



  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :email, presence:true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX,
                    unless: :from_omniauth?
  before_validation :downcase_email

  serialize :oauth_raw_data

  def self.find_by_oauth(omniauth_data)
    self.where(
      uid: omniauth_data['uid'],
      provider: omniauth_data['provider']
    ).first
  end

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data['info']['name'].split(/\s+/)
    self.create(
      uid: omniauth_data['uid'],
      provider: omniauth_data['provider'],
      first_name: full_name.first,
      last_name: full_name.last,
      oauth_token: omniauth_data['credentials']['token'],
      oauth_secret: omniauth_data['credentials']['secret'],
      oauth_raw_data: omniauth_data,
      password: SecureRandom.hex(16)
    )
  end

  def signed_in_with_twitter?
      uid.present? && provider == 'twitter'
  end


  private

  def from_omniauth?
    uid.present? && provider.present?
  end


  def generate_api_token
     loop do
       self.api_token = SecureRandom.urlsafe_base64(32)
       break unless User.exists?(api_token: self.api_token)
     end
   end


  def downcase_email
    self.email.downcase! if email.present?
  end

end
