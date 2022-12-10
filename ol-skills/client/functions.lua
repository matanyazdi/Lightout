
function UpdateSkill(skill, amount)
    if skill and amount then
        if Config.Skills[skill] then
            local xp = Config.Skills[skill].xp
            local level = Config.Skills[skill].level
            if xp + amount > 100 then
                Config.Skills[skill].level = level + 1        
                Config.Skills[skill].xp = xp + amount - 100
                lvlupSkill(skill, Config.Skills[skill].level)
            else
                Config.Skills[skill].xp = xp + amount
            end
        else
            QBCore.Functions.Notify('Skill does not exist??', 'error')
        end
    end
end

function lvlupSkill(skill, lvl)
    local cSkill = Config.Skills[skill]
    QBCore.Functions.Notify('Leveled up on: ' .. skill .. ' to level: ' .. lvl, 'error')
    if not cSkill.custom then
        StatSetInt(cSkill.stat, (cSkill.level * 5), true)
    end
end

function getSkillLVL(skill)
    return Config.Skills[skill].level
end

exports("getSkillLVL", getSkillLVL)
exports("UpdateSkill", UpdateSkill)