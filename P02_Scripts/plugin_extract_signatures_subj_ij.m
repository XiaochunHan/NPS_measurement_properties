% Extract signatures with multiple scaling metrics, add to
% study_canlab_dataset variable.

% --------------------------------------------------------------------------
sim_metric = 'dot_product'; imgscaling = 'none';

[SIG, sigtable] = apply_all_signatures(dat, 'similarity_metric', sim_metric, 'image_scaling', imgscaling);

dat_to_add = sigtable{1};
subjid = study_canlab_dataset{i}.Subj_Level.id{j};

study_canlab_dataset{i} = add_vars(study_canlab_dataset{i}, dat_to_add, 'Event_Level', 'subjectid', subjid);



% --------------------------------------------------------------------------

sim_metric = 'cosine_similarity'; imgscaling = 'none';

[SIG, sigtable] = apply_all_signatures(dat, 'similarity_metric', sim_metric, 'image_scaling', imgscaling);

dat_to_add = sigtable{1};
subjid = study_canlab_dataset{i}.Subj_Level.id{j};

study_canlab_dataset{i} = add_vars(study_canlab_dataset{i}, dat_to_add, 'Event_Level', 'subjectid', subjid);

% --------------------------------------------------------------------------

sim_metric = 'correlation'; imgscaling = 'none';

[SIG, sigtable] = apply_all_signatures(dat, 'similarity_metric', sim_metric, 'image_scaling', imgscaling);

dat_to_add = sigtable{1};
subjid = study_canlab_dataset{i}.Subj_Level.id{j};

study_canlab_dataset{i} = add_vars(study_canlab_dataset{i}, dat_to_add, 'Event_Level', 'subjectid', subjid);


% --------------------------------------------------------------------------

sim_metric = 'dot_product'; imgscaling = 'l2norm_images';

[SIG, sigtable] = apply_all_signatures(dat, 'similarity_metric', sim_metric, 'image_scaling', imgscaling);

dat_to_add = sigtable{1};
subjid = study_canlab_dataset{i}.Subj_Level.id{j};

study_canlab_dataset{i} = add_vars(study_canlab_dataset{i}, dat_to_add, 'Event_Level', 'subjectid', subjid);
