# frozen_string_literal: true

module Quiz
  module Representer
    class GameState
      include Alba::Resource

      attribute :game_id, &:id
      attributes :score
      attributes :correct_answers
      attributes :total_questions
      attributes :current_question_index
      attribute :progress, &:progress_percentage
      attribute :completed, &:completed?
      attribute :hints_used, &:hints_used_count
      attributes :remaining_questions
      attribute :completed_at do |resource|
        resource.completed_at.to_i
      end
      attribute :created_at do |resource|
        resource.created_at.to_i
      end
      attributes :stopwatch_timestamp

      one :current_question do
        attributes :id
        attributes :question_text
        attributes :options
        attributes :category
        attributes :difficulty
      end

      one :current_answer do
        attribute :correct, &:is_correct
        attributes :selected_answer
        attributes :time_taken
      end
    end
  end
end
