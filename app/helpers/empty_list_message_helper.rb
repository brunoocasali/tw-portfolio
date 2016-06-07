module EmptyListMessageHelper
  def empty_list_message(list)
    flash.now[:warning] = t('not_found') if list.empty?

    nil
  end
end
