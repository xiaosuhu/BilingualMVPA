function SubjStats = GLMFirstlevelAnalysis(datadir)
%% GLM Analysis
raw = nirs.io.loadDirectory(datadir, {'Task'});

firstlevelpipeline = nirs.modules.default_modules.single_subject;
List = nirs.modules.pipelineToList(firstlevelpipeline); % Applies job

% Downsample Data from 50Hz to N Hz
List{4}.Fs = 2;

% GLM Basis Function
firstlevelbasis = nirs.design.basis.Canonical();
firstlevelbasis.incDeriv=1;

% Hemodynamic Response Peak Time
firstlevelbasis.peakTime = 6; % peak time determined based on Friederici and Booth papers (insert link)
List{9}.basis('default') = firstlevelbasis;
List{9}.trend_func = @(t) nirs.design.trend.dctmtx(t,0.005);

% Convert the modified list back to pipeline
firstlevelpipeline = nirs.modules.listToPipeline(List);

% Run Job
SubjStats=firstlevelpipeline.run(raw);

end

