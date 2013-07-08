Refinery::Pages.configure do |config|
  # Configure specific page templates
  # config.types.register :home do |home|
  #   home.parts = %w[intro body]
  # end

  # Configure global page default parts
  #config.default_parts = ["Left Column", "Body", "Side Body", "Right Column"]

  # Configure whether to allow adding new page parts
  config.new_page_parts = true

  # Configure whether to enable marketable_urls
  config.marketable_urls = true

  # Configure how many pages per page should be displayed when a dialog is presented that contains a links to pages
  # config.pages_per_dialog = 14

  # Configure how many pages per page should be displayed in the list of pages in the admin area
  # config.pages_per_admin_index = 20

  # Set this to true if you want to override slug which automatically gets generated
  # when you create a page
  # config.use_custom_slugs = false

  # Set this to true to fully expand the page hierarchy in the admin
  config.auto_expand_admin_tree = true

  # config.layout_template_whitelist = ["application"]

  # config.view_template_whitelist = ["home", "show", "show_revert"]

  #config.use_layout_templates = true

  #config.use_view_templates = true

  # config.page_title = {:chain_page_title=>false, :ancestors=>{:separator=>" | ", :class=>"ancestors", :tag=>"span"}, :page_title=>{:class=>nil, :tag=>nil, :wrap_if_not_chained=>false}}

end
