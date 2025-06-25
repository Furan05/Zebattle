module ApplicationHelper
  def position_badge(position)
    color = case position
            when 'Tank' then 'primary'
            when 'Heal' then 'success'
            when 'DPS' then 'danger'
            else 'secondary'
            end

    content_tag :span, position, class: "badge bg-#{color}"
  end

  def team_status(team)
    if team.full?
      content_tag :span, "Complète", class: "badge bg-success"
    else
      remaining = 11 - team.player_count
      content_tag :span, "#{remaining} joueur#{'s' if remaining > 1} manquant#{'s' if remaining > 1}",
                  class: "badge bg-warning text-dark"
    end
  end

  def team_completion_bar(team)
    percentage = (team.player_count.to_f / 11 * 100).round
    color = case percentage
            when 0...50 then 'bg-danger'
            when 50...80 then 'bg-warning'
            when 80...100 then 'bg-info'
            else 'bg-success'
            end

    content_tag :div, class: 'progress', style: 'height: 20px;' do
      content_tag :div, "#{team.player_count}/11",
                  class: "progress-bar #{color} progress-bar-striped",
                  style: "width: #{percentage}%",
                  role: 'progressbar'
    end
  end
end
