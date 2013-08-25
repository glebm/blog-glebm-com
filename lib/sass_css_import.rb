class Sass::Importers::Filesystem
  protected
  alias :extensions_without_css :extensions
  def extensions
    extensions_without_css.merge('css' => :scss)
  end
end