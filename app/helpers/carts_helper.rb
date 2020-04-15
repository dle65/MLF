# frozen_string_literal: true

module CartsHelper
  def rod_author(rod)
    user_signed_in? && current_user.id == rod.user_id
  end
end
