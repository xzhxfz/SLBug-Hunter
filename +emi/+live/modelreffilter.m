function ret = modelreffilter(mutant, sources)
%MODELREFFILTER Summary of this function goes here
%   Detailed explanation goes here
% Documentation only restricts Continuous. why restricting fixed?
% "Variable" was sending continutous signal, so blocking it.
preds = cps.slsf.predecessors([], sources);
preds = cellfun(@getfullname, preds, 'UniformOutput', false);

ret = any(...
            startsWith(... % str, pattern
                cellfun(... % str
                        @(p)mutant.get_compiled(p, 'st').Description,...
                        preds,...
                        'UniformOutput', false ...
                    ),...
                {'Continuous', 'Fixed', 'Variable'},... % pattern
                'IgnoreCase', true...
            )...
        );

end
