CourseYear.import([:id, :title, :content, :version, :mentor_title], [
  ["2ededfd0-38c8-4566-b1d2-f27e5045bff8", "Test Course year", "No content", 1, nil],
  ["dc6d0db1-944c-4257-952c-512836861755", "Test Course year", "No content", 1, nil],
  ["aee72a1e-67b1-4147-9f44-6a288f3fdad9", "Test Course year", "No content", 1, nil]
])
CoreInductionProgramme.import([:id, :name, :course_year_one_id, :course_year_two_id, :slug], [
  ["4b7c51e6-759a-4044-9672-4c1e0daad958", "Test Core induction programme", "2ededfd0-38c8-4566-b1d2-f27e5045bff8", "dc6d0db1-944c-4257-952c-512836861755", "test-cip-270"],
  ["3ac89e6d-4215-4d83-bf68-59bb4a760e7c", "Test Core induction programme", "aee72a1e-67b1-4147-9f44-6a288f3fdad9", nil, "test-cip-271"]
])
CourseModule.import([:id, :title, :ect_summary, :previous_module_id, :course_year_id, :version, :term, :mentor_summary, :page_header], [
  ["4acfe967-2287-4cfa-b9a1-fe2bae1873fa", "Test Course module", "No content", nil, "aee72a1e-67b1-4147-9f44-6a288f3fdad9", 1, "spring", nil, nil]
])
CourseLesson.import([:id, :title, :previous_lesson_id, :course_module_id, :version, :completion_time_in_minutes, :ect_summary, :mentor_summary, :position, :mentor_title, :ect_teacher_standards, :mentor_teacher_standards], [
  ["71a8e181-3376-470a-8801-f195d37e2ba6", "Test Course lesson 142", nil, "4acfe967-2287-4cfa-b9a1-fe2bae1873fa", 1, nil, nil, nil, 1, nil, nil, nil]
])
