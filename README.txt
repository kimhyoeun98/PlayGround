================================================================================================
[Playground Store] 프로젝트 기능 명세서
================================================================================================

[1] 회원 (User) 관련
------------------------------------------------------------------------------------------------
URI                     기능                     Controller                      JSP / 비고
------------------------------------------------------------------------------------------------
/login.do               로그인 폼/처리              LoginController                 /login.jsp
/logout.do              로그아웃 처리               LogoutController                (메인으로 리다이렉트)
/signUp.do              회원가입 폼/처리            	SignUpController                /signUp.jsp
/myInfo.do              마이페이지 (내정보/구매내역) 	MyInfoController                /myInfo.jsp
/pwCheck.do             비밀번호 변경 전 확인       	PwCheckController               /pwCheck.jsp
/pwUpdate.do            비밀번호 변경 처리          	PwUpdateController              (마이페이지로 리다이렉트)
/userDeleteCheck.do     회원 탈퇴 확인              UserDeleteCheckController       /userDeleteCheck.jsp
/userDelete.do          회원 탈퇴 처리              UserDeleteController            (로그아웃 처리)
/userList.do            [관리자] 전체 회원 조회     	UserListController              /userList.jsp


[2] 게임 상점 (Game Store) 관련
------------------------------------------------------------------------------------------------
URI                     기능                     	Controller                      JSP / 비고
------------------------------------------------------------------------------------------------
/gameList.do            전체 게임 목록 조회         	GameListController              /gameList.jsp
/gameDetail.do          게임 상세 정보 조회         	GameDetailController            /gameDetail.jsp
/newGame.do             신규 출시 게임 조회         	NewGameController               /gameList.jsp (재사용)
/bestGame.do            최고 인기(판매순) 조회      	BestGameController              /gameList.jsp (재사용)
/category.do            장르별 카테고리 조회       	CategoryController              /gameList.jsp (재사용)
/gameAdd.do             [관리자] 게임 등록 폼/처리  	GameAddController               /gameAdd.jsp
/gameUpdate.do          [관리자] 게임 수정 폼/처리  	GameUpdateController            /gameUpdate.jsp
/gameDelete.do          [관리자] 게임 삭제        	GameDeleteController            (목록으로 리다이렉트)


[3] 장바구니 (Cart) 관련
------------------------------------------------------------------------------------------------
URI                     기능                     Controller                      JSP / 비고
------------------------------------------------------------------------------------------------
/cartList.do            내 장바구니 목록 조회       	CartListController              /cartList.jsp
/cartAdd.do             장바구니 담기               CartAddController               (목록/상세로 리다이렉트)
/cartDelete.do          장바구니 개별 삭제          	CartDeleteController            (장바구니로 리다이렉트)
/cartDeleteSelected.do  장바구니 선택 삭제			CartDeleteSelectedController	(장바구니로 리다이렉트)
/cartClear.do           장바구니 비우기             	CartClearController             (장바구니로 리다이렉트)
/cartBuy.do             선택 상품 결제              CartBuyController               (라이브러리로 리다이렉트)


[4] 주문 및 포인트 (Order & Point) 관련
------------------------------------------------------------------------------------------------
URI                     기능                     Controller                      JSP / 비고
------------------------------------------------------------------------------------------------
/myOrderList.do         내 라이브러리(구매목록)     	MyOrderListController           /myOrderList.jsp
/pointCharge.do         포인트 충전 폼/처리         	PointChargeController           /pointCharge.jsp
/refund.do              게임 환불 처리              RefundController                (라이브러리로 리다이렉트)


[5] 커뮤니티 (Community) 관련
------------------------------------------------------------------------------------------------
URI                     기능                        Controller                      View (JSP) / 비고
------------------------------------------------------------------------------------------------
/boardList.do           게시글 목록 조회            BoardListController             /boardList.jsp
/boardWrite.do          새 글 작성 폼/처리          BoardWriteController            /boardWrite.jsp
/boardDetail.do         게시글 상세 조회            BoardDetailController           /boardDetail.jsp
/boardDelete.do         게시글 삭제                 BoardDeleteController           (목록으로 리다이렉트)
/replyAdd.do            댓글 작성                   ReplyAddController              (게시글 상세로 리다이렉트)
/replyDelete.do         댓글 삭제                   ReplyDeleteController           (게시글 상세로 리다이렉트)

================================================================================================