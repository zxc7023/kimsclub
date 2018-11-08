package com.kimsclub.groupware.vo;

public class BoardPageVO {
//	public static final int page_scale=5; //게시글 출력 행
	public static final int BLOCK_SCALE=5; //한블럭 당 페이지 수
	
	private int page_scale; //게시글 출력 행
	private int curPage; //현재 페이지 번호
	private int prevPage; //이전 페이지
	private int nextPage; //다음 페이지
	private int totPage; //전체 페이지 갯수
	private int totBlock; //전체 페이지 블록 갯수
	private int curBlock; //현재 페이지 블록
	private int prevBlock; //이전 페이지 블록
	private int nextBlock; //다음 페이지 블록
	private int count;
	
	//where rn between #{start} and #{end}
	private int pageBegin; //#[start}
	private int pageEnd; //#{end}
	
	//[이전] blockBegin -> 41 42 43 44 45 46 47 48 49 50 [다음]
	private int blockBegin; //현재 페이지 블록의 시작번호
	
	//[이전] 41 42 43 44 45 46 47 48 49 50 <blockEnd [다음]
	private int blockEnd; //현재페이지 블록의 끝번호

	//생성자
	//BoardPageVO(레코드 갯수, 현재 페이지 번호)
	public BoardPageVO(int count, int curPage) {
		this.count = count;
		curBlock=1; //현재 페이지 블록 번호
		this.curPage = curPage; //현재 페이지 설정
		setTotPage(count); //전체 페이지 갯수 계산
		setPageRange();
		setTotBlock(); //전체 페이지 블록 갯수 계산
		setBlockRange(); //페이지 블록의 시작, 끝 번호 계산
	}

	public BoardPageVO(int count, int curPage, int page_scale) {
		this.count = count;
		curBlock=1; //현재 페이지 블록 번호
		this.page_scale = page_scale;
		this.curPage = curPage; //현재 페이지 설정
		setTotPage(count); //전체 페이지 갯수 계산
		setPageRange();
		setTotBlock(); //전체 페이지 블록 갯수 계산
		setBlockRange(); //페이지 블록의 시작, 끝 번호 계산
	}
	
	public void setBlockRange() {
		//현재 페이지가 몇번째 페이지 블록에 속하는지 계산
		curBlock = (int)((curPage-1) / BLOCK_SCALE)+1;
		//현재 페이지 블록의 시작, 끝 번호 계산
		blockBegin = (curBlock-1)*BLOCK_SCALE+1;
		//페이지 블록의 끝번호
		blockEnd =blockBegin+BLOCK_SCALE-1;
		//마지막 블록이 범위를 초과하지 않도록 계산
		if(blockEnd>totPage) blockEnd = totPage;
		//이전에 눌렀을 때 이동할 페이지 번호
		/*prevPage = (curPage==1)?1:(curBlock-1)*BLOCK_SCALE;*/
		prevPage = (curPage==1)?1:curPage-1;
		//다음 눌렀을때 이동할 페이지 번호
		/*nextPage = curBlock > totBlock?(curBlock * BLOCK_SCALE) : (curBlock*BLOCK_SCALE)+1;*/
		nextPage = curPage+1;
		//마지막 페이지가 범위를 초과하지 않도록 처리
		if(nextPage>=totPage) nextPage = totPage;
	}
	
	public void setPageRange() {
		//where rn between #{start} and #{end}
		//시작번호=(현재페이지-1)*페이지당 게시물수+1
		pageBegin = (curPage-1)*page_scale+1;
		//끝번호 = 시작번호+페이지당 게시물수-1
		pageEnd = pageBegin+page_scale-1;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotPage() {
		return totPage;
	}

	public void setTotPage(int count) {
		//Math.ceil(실수) 올림 처리
		totPage=(int)Math.ceil(count*1.0/page_scale);
	}

	public int getTotBlock() {
		return totBlock;
	}

	public void setTotBlock() {
		//전체 페이지 갯수/10
		//91/10 => 9.1=>10개
		totBlock = (int)Math.ceil(totPage*1.0/BLOCK_SCALE);
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	public int getPage_scale() {
		return page_scale;
	}

	public void setPage_scale(int page_scale) {
		this.page_scale = page_scale;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
	
}
