function save_plots(fig_handle, filename_prefix)
    filename   = strcat(filename_prefix, '.fig');

    savefig(filename)
    file_name_pdf = strcat(filename_prefix, '.pdf');
    file_name_png = strcat(filename_prefix, '.png');
    set(fig_handle,'PaperOrientation','landscape');
    fillPage(fig_handle)
    print(fig_handle, '-dpdf', '-r150', file_name_pdf);
    print(fig_handle, '-dpng', '-r150', file_name_png);
