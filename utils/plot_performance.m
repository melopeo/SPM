function fig_handle = plot_performance(mean_Matrix, xArray, legendCell, colorCell, LineStyleCell, markerCell, MarkerSize, LineWidthCell,legendLocation,xAxisTitle_str,yAxisTitle_str, title_str, fontSize,fontSize_legend,legendBoolean,xTickArray,yTickArray)

    fig_handle = figure; hold on

    for j = 1:size(mean_Matrix,1)
        meanVec = mean_Matrix(j,:);

        plot(xArray,meanVec, ...
            'Color',colorCell{j}, ...
            'Marker', markerCell{j}, ...
            'MarkerFaceColor', colorCell{j}, ...
            'MarkerEdgeColor',colorCell{j}, ...
            'LineWidth', LineWidthCell{j}, ...
            'LineStyle', LineStyleCell{j}, ...
            'MarkerSize',10);
    end
    set(gca,'XTick', xArray(xTickArray))
    set(gca,'YTick', yTickArray)
    if legendBoolean
        legend(legendCell,'Location',legendLocation, 'Interpreter','latex','FontSize',fontSize_legend)
    end
    axis square tight
    box on
    daspect

    ax = gca;
    title(title_str, 'interpreter', 'latex', 'FontSize', fontSize)
    set(gca,'fontweight','bold', 'FontSize', fontSize);
    
    ylabel(yAxisTitle_str, 'interpreter', 'latex', 'FontSize', 35,'fontweight','bold', 'FontName', 'Helvetica')
    xlabel(xAxisTitle_str, 'interpreter', 'latex', 'FontSize', 35,'fontweight','bold', 'FontName', 'Helvetica')
