package com.example.neoheulge.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.MemberDTO;

@Service
public class AdminService {

    @Autowired
    private AdminDAO admindao;

    // 캐시 이름을 'members'로 지정하고, 캐시 키를 자동 생성
    @Cacheable(value = "members", key = "'allMembers::' + #offset + ':' + #size")
    public List<MemberDTO> MemberAll(int offset, int size) {
        // 파라미터를 Map에 담아서 DAO에 전달
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("size", size);
        List<MemberDTO> members = admindao.memberAll(params);
        System.out.println("Fetched members: " + members.size());
        return admindao.memberAll(params);
        
    }

    @Cacheable(value = "members", key = "'search::' + #searchType + ':' + #searchKeyword + ':' + #offset + ':' + #size")
    public List<MemberDTO> searchMember(String searchType, String searchKeyword, int offset, int size) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("offset", offset);
        params.put("size", size);
        return admindao.searchMember(params);
    }

    // 총 데이터 개수 반환
    public int getTotalCount(String searchType, String searchKeyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        return admindao.getTotalCount(params);
    }
    
}
