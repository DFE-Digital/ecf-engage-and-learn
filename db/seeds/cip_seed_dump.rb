CourseYear.import([:id, :title, :content, :version, :mentor_title], [
  ["336d4575-4312-48ac-84a0-6b066467fb21", "Test Course year", "No content", 1, nil],
  ["47b9699b-9f63-401a-ab70-221f96baa751", "Test Course year", "No content", 1, nil],
  ["31b2e92c-090a-40e3-869e-a52379654fb7", "Test Course year", "No content", 1, nil]
])
CoreInductionProgramme.import([:id, :name, :course_year_one_id, :course_year_two_id, :slug], [
  ["c99f72e8-a5d3-4c70-a852-481dba22c168", "Test Core induction programme", "336d4575-4312-48ac-84a0-6b066467fb21", "47b9699b-9f63-401a-ab70-221f96baa751", "test-cip-178"]
])
CourseModule.import([:id, :title, :ect_summary, :previous_module_id, :course_year_id, :version, :term, :mentor_summary, :page_header], [
  ["66b33c24-dbca-4a6b-b0eb-11cae10dfd4f", "Test Course module", "No content", nil, "31b2e92c-090a-40e3-869e-a52379654fb7", 1, "spring", nil, nil]
])
CourseLesson.import([:id, :title, :previous_lesson_id, :course_module_id, :version, :completion_time_in_minutes, :ect_summary, :mentor_summary, :position, :mentor_title, :ect_teacher_standards, :mentor_teacher_standards], [
  ["b36179f0-32e1-472c-aeb1-17c147f602d6", "Test Course lesson 129", nil, "66b33c24-dbca-4a6b-b0eb-11cae10dfd4f", 1, nil, nil, nil, 1, nil, nil, nil]
])
