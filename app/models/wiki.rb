class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope { order('updated_at DESC') }
  scope :visible_to, -> (user) { user && !user.standard? ? all : where(public: true) }

  def markdown_body
    render_as_markdown body
  end

  def markdown_title
    render_as_markdown title
  end

  private

  def render_as_markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
