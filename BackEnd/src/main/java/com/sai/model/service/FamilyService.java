package com.sai.model.service;

import java.util.List;

import com.sai.model.dto.family.FamilyCallsignDto;
import com.sai.model.dto.family.FamilyDto;
import com.sai.model.dto.family.FamilyRegisterDto;
import com.sai.model.dto.family.UpdateFamilyVo;
import com.sai.model.dto.user.UserDto;

public interface FamilyService {

	public UserDto createFamilyId(String userId);

	public UserDto disjoinFamily(String userId);

	public void applyFamily(FamilyRegisterDto familyRegister);

	public List<FamilyCallsignDto> responseApplication(String userId, FamilyRegisterDto familyRegister);

	public FamilyRegisterDto resultApplication(String userId);

	public void deleteApplication(String userId);

	public FamilyDto searchFamily(String familyId);

	public List<FamilyCallsignDto> searchFamilyList(String userId);

	public UpdateFamilyVo updateFamily(UpdateFamilyVo updateFamilyVo);

}
