function SubjStats = GLMFirstlevelAnalysis(datadir)
%% GLM Analysis
raw = nirs.io.loadDirectory(datadir, {'Task'});

firstlevelpipeline = nirs.modules.default_modules.single_subject;
List = nirs.modules.pipelineToList(firstlevelpipeline); % Applies job

% Downsample Data from 50Hz to N Hz
List{4}.Fs = 2;

% GLM Basis Function
firstlevelbasis = nirs.design.basis.FIR;
firstlevelbasis.isIRF=1;
firstlevelbasis.binwidth=1;
firstlevelbasis.nbins=12;
List{9}.basis('default')=firstlevelbasis;


% Convert the modified list back to pipeline
firstlevelpipeline = nirs.modules.listToPipeline(List);

% Run Job
SubjStats=firstlevelpipeline.run(raw);

end

