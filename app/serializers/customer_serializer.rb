class CustomerSerializer < ActiveModel::Serializer
  attributes :id,:name,:address1,:state,:city,:business,:company_name,:phone1,:phone2,:salutation,:county
end
