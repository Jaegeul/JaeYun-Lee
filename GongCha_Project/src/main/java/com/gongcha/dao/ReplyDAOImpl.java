package com.gongcha.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gongcha.dto.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReplyDTO> replyList(ReplyDTO dto) {
		return sqlSession.selectList("reply_list",dto);
	}

	@Override
	public void replyRegi(ReplyDTO re) {
		
		//현재 recruit_reply 테이블의 가장 큰 no값을 가져온다.
		try {
			int re_class = sqlSession.selectOne("reply_max_no");
			
			re.setReply_class(re_class+1);
		}catch(NullPointerException e){
			int re_class = 0;
			
			re.setReply_class(re_class+1);
		}
		
		//class 세팅
		
//		int result = sqlSession.insert("reply_wrtie", re);
		sqlSession.insert("reply_wrtie", re);
		
		//--------------------------------------------
//		int check = sqlSession.selectOne("reply_max_no");
		//class를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값으로 세팅함
//		re.setReply_class(check);
		
		//no와 class가 다르면 class를 no로 업데이트
//		int check_update = sqlSession.update("reply_check", re);
		
		//reply 테이블에 새로운 댓글 추가가 성공하면 갱신된 댓글 갯수를 가져온다
//		if(result == 1) {
//			re = sqlSession.selectOne("reply_count",re);
//		}
		
	}
}
