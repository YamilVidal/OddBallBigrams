% Parameters to draw in the test phase
cr      = 0.015;    % radius of the marker as proportion of heigth of the window
cr      = cr*window(2);        % radius of the marker

colorc1 = [0 0 1];  % color of the circle before the final answer

l_l     = 0.4;    % line length as proportion of the window
l_v     = 0.5;    % line vertical possition as proportion of the window
l_l     = l_l*window(1);       % line length
l_v     = l_v*window(2);       % line vertical possition

l_hi    = (window(1)-l_l)/2;   % line initial horizontal point
l_hf    = l_hi+l_l;            % line final horizontal point