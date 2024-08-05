package com.example.neoheulge.qna.service;

import java.util.List;

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
		 return sqlSession.delete("QnaDelete",id);
	 }
	 
	 public int qnaUpdate(QnaDTO dto) {
			return sqlSession.update("QnaUpdate", dto);
		}
}
