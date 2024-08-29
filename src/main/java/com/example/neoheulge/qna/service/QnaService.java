package com.example.neoheulge.qna.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.QnaDTO;



@Service
public class QnaService {

	@Autowired
	private  SqlSession sqlSession;
	
	public List<QnaDTO> qnaList(){
		return sqlSession.selectList("qnaList");
	}
	
	public int qnaWrite(QnaDTO dto) {
		return sqlSession.insert("qnaWrite",dto);
	}
	
	 public void qnaNewSetp(int id) {
		 sqlSession.update("qnaNewStep",id);
	 }
	 
	 public void qnaReStep(int id) {
	     sqlSession.update("qnaReStep",id);
	 }
	 
	 public QnaDTO getQna(int id) {
		 return sqlSession.selectOne("getQna",id);
	 }
	 
	 public int qnaViews(int id) {
			return sqlSession.update("qnaViews", id);
		}
	 
	 public int qnaDelete(int id) {
		 return sqlSession.delete("qnaDelete",id);
	 }
	 
	 public int qnaUpdate(QnaDTO dto) {
			return sqlSession.update("qnaUpdate", dto);
		}
	 
	 public List<QnaDTO> searchQnaList(String searchType, String search) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("searchType", searchType);
	        params.put("search", search);
	        return sqlSession.selectList("searchQnaList", params);
	    }
	 
	 public int deleteEditQna(String member_id) {
		 return sqlSession.update("deleteEditQna",member_id);
	 }
}
