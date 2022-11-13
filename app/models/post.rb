class Post < ApplicationRecord
#==============CALLBACKS================>
has_many :comments, dependent: :destroy

#--------------------VALIDATIONS-------------------->
validates :title, presence: true , uniqueness: true

validates :body, presence: true, length: { minimum: 50 }

end
