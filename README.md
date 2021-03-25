<%Like.group(:exercise_id).order('COUNT(exercise_id) DESC').each do |like|%>
            <%exercise = Exercise.find_by_id(like.exercise_id)%>


