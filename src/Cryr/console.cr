require "./version.cr"
require "../../lib/libtcod/src/libtcod.cr"

module ColorScheme
  BLACK       = LibTCOD::ColorT.new r:0x11u8, g:0x11u8, b:0x11u8
  WHITE       = LibTCOD::ColorT.new r:0xdbu8, g:0xdbu8, b:0xdbu8
  LIGHT_GRAY  = LibTCOD::ColorT.new r:0x9eu8, g:0x9eu8, b:0x9eu8
  DARK_GRAY   = LibTCOD::ColorT.new r:0x3au8, g:0x3au8, b:0x3au8
  LIGHT_BLUE  = LibTCOD::ColorT.new r:0x22u8, g:0x5bu8, b:0xb7u8
  LIGHT_GREEN = LibTCOD::ColorT.new r:0x2au8, g:0xb7u8, b:0x22u8
  LIGHT_RED   = LibTCOD::ColorT.new r:0xc1u8, g:0x13u8, b:0x13u8

  DEFAULT_BACKGROUND = BLACK
  DEFAULT_FOREGROUND = WHITE
end

class Console
  alias FF = LibTCOD::FontFlagsT

  @@TITLE : String = "Cryr v" + Cryr::VERSION
  @@RENDERER = LibTCOD::RendererT::RENDERER_OPENGL
  @@FPS = 60

  @dimensions : {Int32, Int32}

  def initialize( w, h, fs )

  @dimensions = {w, h}
  flags = FF::FONT_LAYOUT_ASCII_INROW | FF::FONT_TYPE_GRAYSCALE

  LibTCOD.console_set_custom_font "terminal.png", flags, 16, 16
  LibTCOD.console_init_root w, h, @@TITLE, fs, @@RENDERER
  LibTCOD.sys_set_fps 60
  LibTCOD.console_set_default_foreground nil, ColorScheme::DEFAULT_FOREGROUND
  LibTCOD.console_set_default_background nil, ColorScheme::DEFAULT_BACKGROUND
  clear
  end

  def game_loop( &block )
    while (!LibTCOD.console_is_window_closed)
      if yield
        break
      end
    end
  end

  def put_char( chr, x, y, fg? = nil, bg? = nil )
    fg = fg? || ColorScheme::DEFAULT_FOREGROUND
    bg = bg? || ColorScheme::DEFAULT_BACKGROUND
    LibTCOD.console_put_char_ex( nil, x, y, chr, fg, bg )
  end

  def flush
    LibTCOD.console_flush
  end

  def clear
    LibTCOD.console_clear nil
  end
end
