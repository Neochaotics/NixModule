{
  programs.nvf.settings.vim.comments.comment-nvim = {
    enable = true;

    mappings = {
      toggleCurrentBlock = "gbc";
      toggleCurrentLine = "gcc";
      toggleOpLeaderBlock = "gb";
      toggleOpLeaderLine = "gc";
      toggleSelectedBlock = "gb";
      toggleSelectedLine = "gc";
    };

    setupOpts = {
      mappings = {
        basic = true;
        extra = true;
      };
    };
  };
}
