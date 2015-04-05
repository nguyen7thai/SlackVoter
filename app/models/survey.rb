class Survey < ActiveRecord::Base
  has_many :votes
  serialize :options, Array

  def full_description
    text = "*#{title}*\n_#{description}_\n"
    options.each_with_index do |option, index|
      text += "#{index + 1}. #{option['text']}\n"
    end
    text
  end

  def text_after_vote(vote)
    text = "#{vote.slack_user_name} has voted for `#{options[vote.choice.to_i]['text']}`\n"
    current_choices_count.each do |key, value|
      name_list = votes.where(choice: key).pluck(:slack_user_name).join(', ')
      text += "*#{options[key.to_i]['text']}*: `#{value}` (#{name_list})\n"
    end
    text
  end

  def current_choices_count
    votes.group(:choice).count
  end

  def current_user_choice
    votes.select('sum(slack_user_name)').group
  end
end
