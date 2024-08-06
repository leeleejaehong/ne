package com.example.neoheulge.notice.service;

import com.example.neoheulge.dto.NoticeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoticeService {

    @Autowired
    private SqlSession sqlSession;

    public List<NoticeDTO> noticeList(){
        return sqlSession.selectList("noticeList");
    }

    public int noticeInsert(NoticeDTO dto) {
        return sqlSession.insert("noticeInsert",dto);
    }

    public NoticeDTO getNotice(int id) {
        return sqlSession.selectOne("getNotice",id);
    }

    public int noticeViews(int id) {
        return sqlSession.update("noticeViews", id);
    }

    public int noticeDelete(int id) {
        return sqlSession.delete("noticeDelete",id);
    }

    public int noticeEdit(NoticeDTO dto) {
        return sqlSession.update("noticeEdit", dto);
    }

    public List<NoticeDTO> searchNoticeList(String searchType, String search) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("search", search);
        return sqlSession.selectList("searchNoticeList", params);
    }

}