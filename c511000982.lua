--Release Change
function c511000982.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RELEASE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000982.target)
	e1:SetOperation(c511000982.activate)
	c:RegisterEffect(e1)
end
function c511000982.filter(c,e,tp,ft)
	return c:IsReleasableByEffect() and (ft>0 or c:GetSequence()<5)
		and Duel.IsExistingMatchingCard(c511000982.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetLevel())
end
function c511000982.spfilter(c,e,tp,lv)
	return c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000982.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c511000982.filter(chkc,e,tp,ft) end
	if chk==0 then return ft>-1 and Duel.IsExistingTarget(c511000982.filter,tp,LOCATION_MZONE,0,1,nil,e,tp,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTarget(tp,c511000982.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp,ft)
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000982.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Release(tc,REASON_EFFECT)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000982.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetLevel())
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
