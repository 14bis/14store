VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
VALID_PHONE_REGEX = /\A[0-9\s()\-.]+\z/i  
ROLE_ADMIN = Spree::Role.find_by_name("admin")
ROLE_PROVIDER = Spree::Role.find_by_name("provider")
ROLE_USER = Spree::Role.find_by_name("user")
