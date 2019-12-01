def show
  @students = Student.joins(:subjects)
                     .select('students.name, students.email, students.age, students.gender, students.opinion, subjects.id as subject_id')
                     .select('exam_results.name as exam_result_name, subjects.name as subject_name, exam_results.score')
                     .select('CAST((exam_results.score / subjects.max_score) * 100 as int) as ratio')
                     .where(id: params[:id])
                     .order(id: :asc)

  avg_result = Student.joins(:subjects)
                      .select('subjects.id as subject_id')
                      .select('CAST(AVG(exam_results.score) as int) as avg_score')
                      .select('MAX(exam_results.score) as max_score')
                      .select('MIN(exam_results.score) as min_score')
                      .group('subjects.id')
                      .order('subjects.id')
  @score_hash = {}
  avg_result.each do |avg_res|
    h = {}
    h[:avg_score] = avg_res.avg_score
    h[:max_score] = avg_res.max_score
    h[:min_score] = avg_res.min_score
    @score_hash[avg_res.subject_id] = h
  end
  end
