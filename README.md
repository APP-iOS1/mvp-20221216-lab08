
### 뚜셰 이전 프로젝트 Readme
#### [뚜셰 1차 프로토타입 Readme](https://www.shorturl.at/bqvIQ)<br/>
#### [뚜셰 2차 프로토타입 Readme](https://www.shorturl.at/sJOP9)<br/>
#### [뚜셰 스토리보드 (피그마)](https://www.shorturl.at/lMORV)<br/>
<br/><br/><br/>

 <h1 align="middle">뚜셰(Touché)</h1>
 <p align="middle"><img src="https://user-images.githubusercontent.com/114331071/208329761-5e65d8b0-1ae5-4521-8be8-aec4e6a943f8.png" width=30%></p>
 <p align="middle">향수를 시각화하다, 가장 직관적인 시각 데이터 기반 향수 소셜 커뮤니티 앱 뚜셰입니다.</p><br/><br/><br/>

 
 ## 앱 정의(ADS)
<p align></p>
<p align>뚜셰는 향수 정보를 제공하고 커뮤니티화할 수 있는 앱 플랫폼의 부재를 확인한 데서 출발하였습니다.</p>
<p align>뚜셰는 향수의 정보를 소개하는 일반적인 기능을 제공할 뿐 아니라, 각 향기 정보를 색채 정보로 치환하여 나타냅니다.</p>
<p align>이로써 뚜셰 내에서는 두 개 이상의 향수의 차이(분위기, 무게감)를 보다 쉽게 파악할 수 있습니다.</p>
<p align>보다 직관성을 가진 향수 정보를 통해 전 세계 사람들이 이용하는 향수 전문 커뮤니티를 지향합니다.</p>
<br/><br/><br/>


## 앱 설치 가이드라인
1. 하단 첨부 이미지에 따라 로컬 저장소에 파일을 다운로드 부탁드립니다.
2. 시뮬레이터는 아이폰 14 Pro, Light Mode Only, Portrait Mode Only 환경으로 실행 요청드립니다.
3. 이 앱은 향수 정보에 접근하기 위한 조건으로 로그인이 강제되지 않습니다.
4. 내 계정 탭, 회원 가입 시 약 2-3초간의 대기 시간이 소요 됩니다.
5. 홈 탭 내 '지금 실시간 코멘트 많이 달린 향수' 를 클릭 시 상단 '최근 본 향수' 에 랜덤으로 쌓이게 됩니다. 
6. 로그인 / 비로그인 사용자를 분리하여 댓글, 좋아요 기능 접근에 차등을 두는 뷰를 구현하지 못했습니다.
<br/>
<p align="center"><img src="https://user-images.githubusercontent.com/114331071/209336009-d1599a92-ce42-434f-91cb-3263a564aab9.png" width=80%></p>
<br/><br/><br/>

## GIF 앱 화면
| <img src="https://user-images.githubusercontent.com/114331071/209337549-2e93402d-026e-42f3-a70d-e20ff1793a0a.mov" width="180"/> |  <img src="https://user-images.githubusercontent.com/114331071/209337919-83f8ec30-a2e3-4018-849d-093d1569a99b.mov" width="180"/>  |  <img src="https://user-images.githubusercontent.com/114331071/209338448-ba8a7935-5d12-4675-a29b-222579d60f08.mov" width="180"/> | <img src="https://user-images.githubusercontent.com/114331071/209337549-2e93402d-026e-42f3-a70d-e20ff1793a0a.mov" width="180"/> |
| :-: | :-: | :-: | :-: |
| 홈 | 홈 화면 내 댓글 달기 | 브랜드, 색 필터링 | 내 계정 |


<br/><br/><br/>











<br/><br/><br/>
## MVP 목표 달성률
- 메인 목표 달성과제 3/4 해결, 75% 완료.
- 추가 기능 목표 달성과제 0/2 해결, 0% 완료. 
<br/><br/><br/>

## 기술 한계점
1. HomeView -> Store 연결 유저가 선택한 향수에 ULD 삽입하지 않고(PerfumeSotre)
   유저 정보에 유저가 선택한 향수(ClickedStore)를 따로 만들어 관리하여 데이터 중복, 동기화되지 않는 문제
2. DetailView -> 좋아요 버튼 클릭 시 UserStore 내 likePerfumes 와 미연동,
   Review 내 작성시간(createdAt -> Date 변환 불가) 미노출
3. SearchView -> Query 비동기 함수를 생성해 DB에서 데이터를 직접 가져오지 못함
4. GoogleSignIn 시 nickName값 받아오지 못하는 문제
5. 일반 로그인 시 FirebaseAuth 내 유저프로필 정보를 저장하지 못함
6. 로그인 실패 에러 핸들링 미구현
7. 로그인 사용자와 비로그인 사용자별 뷰 구분 미구현
8. 로그인 / 비로그인 사용자의 MyPage 내 설정/ 고객지원 스크롤 높이 통일 미구현
9. HomeView safeArea 색 전환 미구현
10. 기획 : 향수 무게감에 따른 색상 별 위도값을 나타내는 것에 대한 기획 부족
<br/><br/><br/>


## 주요기능
- 향수 정보 제공 및 의견 공유가 가능한 커뮤니티 기능
- 브랜드, 색채 정보를 활용한 향수 정보 필터화 기능
- 향수 색채 정보 애니메이션화를 통한 직관적인 향수 분위기 정보 전달 기능
<br/><br/><br/>


## MVP 목표 (주요 기능)
> 100% 달성 목표
- [x] 기존 프로토타입에서 하드코딩으로 구성했던 화면 요소 데이터화_12/20 완료
- [x] 추후 데이터의 수정 및 관리가 용이한 방향의 데이터 구조화 및 데이터 저장 플뢧폼 채택_12/20 완료
- [x] 프로토타입2 화면 구성 요소에 저장된 데이터 적용_12/20 진행중 12/22 완료
- [ ] 향수에 대한 *저관여자*, *고관여자별* 검색 기능 제공
      (저관여자: 향수에 관한 정보가 낯선 사람, 고관여자: 향수에 대한 정보가 친숙하고, 지식이 많은 사람)
<br/><br/><br/>


## MVP 목표 (부가 기능)
> 주요 기능 달성 후, 스케줄에 따라 추가 구현 가능한 기능
- [ ] 향수 세부 정보에 공유 기능을 추가해 앱 설치 링크 전달
- [ ] 홈뷰 스크롤 시 세이프티에리어와 홈뷰의 접점 색감 통일
<br/><br/><br/>


## 일자별 완료 목록
> 12/16 금
- [x] MVP 팀원간 자기소개 및 뚜셰 아이덴티티 공유
- [x] 뚜셰 1차, 2차 프로토타입 소개
- [x] 주요 기능, 부가 기능 회의 및 달성 목표 설정
- [x] 화면 내 데이터화할 구성 요소 확인
- [x] 데이터 구조화 회의

> 12/19 월
- [x] 파이어베이스를 활용한 데이터 구조체 생성
- [x] 데이터 CRUD 및 Store 저장
- [x] 2차 프로토타입 뷰 기준 추가 구현 필요한 목업 뷰 생성

> 12/20 화
- [x] Firestore에 데이터 축적 가능한 Touche manager 앱 생성, 뷰 별 기술 문제점 해결 및 서포트 (은노)
- [x] MyPageView 화면 구성, 이메일 로그인 구현 (미주, 석진)
- [x] Firebase 데이터 연동한 HomeView 화면 구성 (종환)
- [x] Firebase 데이터 연동한 HomewDetailView 화면 구성 (영서)
- [x] HomeView, HomeDetailView 연동 (영서, 종환)
- [x] Firestore에 데이터 축적, Readme 업데이트 (유진)

> 12/21 수
- [x] Search > SearchView 내 원하는 데이터 필터링 통한 FilteringResultView 생성 및 구현 (은노)
- [x] MyPage > LikedPerfumeListView 추가를 통한 로그인 사용자의 관심 향수 리스트 생성 및 구현 (미주, 석진)
- [x] Home > ClickedCellView 추가를 통한 클릭한 향수 리스트를 HomeView 내 추가 및 구현 (종환)
- [x] DetailView > CommentView, Review 추가를 통한 향수 디테일 뷰 내 댓글 기능 생성 및 구현 (영서)
- [x] DetailView > 컬러바 에셋 이미지 추가를 통한 개별 향수 데이터에 따른 컬러바 노출 생성 및 구현, Readme 업데이트 (유진)

> 12/22 목
- [x] 유민영 강사님 및 조별 상호 피드백을 통한 개선사항 정리 및 목표 재설정

> 12/23 금
- [x] HomeView > 최근 본 향수와 DetailView 연결 (종환)
- [x] DetailView > 뷰 정렬, 코멘트 추가 시 Review 내 즉시 반영 (영서) 
- [x] HomeView > SafeArea 적용, Readme 업데이트 (유진)
- [x] LoginView 내 전체 UI 정렬, 회원가입 시 예외 처리 기능 업데이트_MVP lab16 : 떡볶잉 팀 코드 참조 (미주, 석진) 
- [x] DetailVIew > Firebase 에 저장된 컬러 데이터 접근을 통한 뷰별 애니메이션 기능 업데이트 (은노) <br/><br/><br/>


## 뷰 별 피드백 정리
디자인 피드백
> 홈뷰
>> 1. 세이프티 에리어 적용
>> 2. 하단 마진 넓이 추가
>> 3. 검색한 브랜드에 로고 추가
>> 4. 내가 클릭한 향수 워딩 변경

> 디테일뷰
>> 1. 하단 마진 넓이 추가
>> 2. 상세 정보, 코멘트 커뮤니티 버튼 개선
>> 3. 노트 정보 노출 개선
>> 4. 코멘트 / 커뮤니티 클릭 후 상세 정보 버튼 클릭 시 튕겨나가는 부분 개선
>> 5. 상세 뷰 내 콘텐츠 마진 추가
>> 6. 코멘트 / 커뮤니티 작성완료 버튼 직관성 추가
>> 7. 막대바 위치 변경
>> 8. 하단 탭 바 추가

> 카테고리뷰
>> 1. 브랜드 선택칸과 색상 선택칸 사이의 구분 불명확
>> 2. 브랜드 선택 카테고리와 색상 선택 카테고리의 뷰 흐름 재정의
>> 3. 선택한 브랜드와 선택한 색상이 세로로 쌓일 수 있도록 개선
>> 4. 하단 마진 넓이 추가 
>> 5. FilteringResultView 선택 시 탭 추가
>> 6. 선택한 브랜드 및 색상 캡슐화하여 정렬
>> 7. 색상 하단에 대한 정보 추가

> 내 계정뷰
>> 1. 텍스트필드 그룹핑 강화
>> 2. 텍스트필드 테두리 수정
>> 3. 구글 버튼 수정

기술 피드백
> UserStore 전부 부르기보다 UserDefault에 저장
> Query 함수 대신 WhereField 검색 참조 (12/22 은노 수정 완료)


<br/><br/><br/>


## 팀원

| <img src="https://avatars.githubusercontent.com/u/114036537?v=4" width=200> | <img src="https://avatars.githubusercontent.com/u/114224237?v=4" width=200> | <img src="https://avatars.githubusercontent.com/u/33450365?v=4" width=200> | <img src="https://avatars.githubusercontent.com/u/98254580?v=4" width=200> | <img src="https://avatars.githubusercontent.com/u/70871997?s=96&v=4" width=200> | <img src="https://avatars.githubusercontent.com/u/114331071?s=96&v=4" width=200> |
| :----------------------------------------------------------: | :---------------------------------------------: | :-------------------------------------------------: | :-------------------------------------------------: |  :-------------------------------------------------: |  :-------------------------------------------------: |
| 미주<br/>[@mumjee03](https://github.com/mumjee03)<br/> | 영서<br/>[@yngddo](https://github.com/yngddo)<br/> | 은노<br/> [@Eunno-An](https://github.com/Eunno-An)<br/> | 종환<br/>[@JJH0729](https://github.com/JJH0729)<br/> | 석진<br/>[@tjrwls](https://github.com/tjrwls)<br/> | 유진<br/>[@yooj1202](https://github.com/yooj1202)<br/> |

