class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginatingDecorator
  end

  class PaginatingDecorator < Draper::CollectionDecorator
    delegate :page_size, :page_range, :page_count, :current_page, :next_page, :prev_page,
    :first_page?, :last_page?, :pagination_record_count, :current_page_record_count, :current_page_record_range
  end
end
