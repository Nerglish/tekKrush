local f = CreateFrame("Frame")
f:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
f:RegisterEvent("CONFIRM_LOOT_ROLL")
f:RegisterEvent("LOOT_BIND_CONFIRM")
f:SetScript("OnEvent", function(self, event, id, rollType)
-- TekKrush based code from ShestakUI
        if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
                local elapsed = 0
                self:SetScript("OnUpdate", function(self, elap)
                        elapsed = elapsed + elap
                        if elapsed < 0.2 then
                                StaticPopup_Hide("LOOT_BIND")
                                return
                        end
                        elapsed = 0
                        ConfirmLootSlot(id)
                        self:SetScript("OnUpdate", nil)
                end)
        else
                for i = 1, STATICPOPUP_NUMDIALOGS do
                        local frame = _G["StaticPopup"..i]
                        if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
                end
        end
end)


-- StaticPopupDialogs["LOOT_BIND"].OnCancel = function(self, slot)
-- 	if GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 then ConfirmLootSlot(slot) end
-- end
