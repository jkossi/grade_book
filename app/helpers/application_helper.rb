require 'constants'

module ApplicationHelper
  def registrations_controller?(is_devise, controller_name)
    is_devise && controller_name != 'registrations'
  end

  def full_name(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def is_admin?(user)
    user.role_id == 1
  end

  def initials(user)
    "#{user.first_name[0].upcase}#{user.last_name[0].upcase}"
  end

  def get_year(date)
    Date.parse(date).year
  end

  def delete_message(model_name, references = '')
    phrase = references.present? ? " , #{references}" : '.'
    "Deleting this #{model_name} will also delete any associated items#{phrase} Are you sure you want to delete?"
  end

  def display_gender(gender)
    if gender.present?
      gender ===  'm' ? 'Male' : 'Female'
    end
  end

  def display_role(role_id, user_id)
    if user_id.nil? && role_id === 1
      return 'super admin'
    end

    case role_id
      when 1 then ROLES[role_id  - 1]
      when 2 then ROLES[role_id - 1]
      else        ''
    end
  end

  def academic_session_status(closed)
    closed ? 'Closed' : 'Open'
  end
end
