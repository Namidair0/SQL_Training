-- [FROM 절의 JOIN 형태에 따른 분류]
-- INNER JOIN : JOIN 조건에서 값이 일치하는 행만 반환
-- OUTER JOIN : JOIN 조건에서 한쪽 값이 없더라도 행을 반환
-- INNER JOIN > [연산자에 따은 분류]
-- EQUI JOIN : 두 테이블 간의 칼럼 값들이 서로 일치하는 경우 ( '=' 연산자 사용)
-- NON EQUI JOIN : 두 테이블 간의 칼럼 값들이 서로 일치하는 경우 (비교 연산자 사용)

-- SELF JOIN
-- 사원들의 매니저를 출력하시오. 
SELECT employee.ENAME || '의 매니저는' || manager.ENAME || '입니다.'
FROM EMP employee, EMP manager
WHERE employee.MGR =  manager.EMPNO;

-- 외부 조인(Outer Join)
SELECT employee.ENAME, manager.ENAME
FROM EMP employee, EMP manager
WHERE employee.MGR =  manager.EMPNO(+);

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- 사원 테이블과 부서 테이블을 조인하여 사원이름(ENAME)과 부서번호(DEPTNO)와 부서명(DNAME)을 출력
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

-- 표준(ANSI) JOIN
SELECT * 
FROM EMP CROSS JOIN DEPT;

SELECT ENAME, DNAME 
FROM EMP INNER JOIN DEPT
         ON EMP.DEPTNO = DEPT.DEPTNO;   -- 조인 조건
         
SELECT ENAME, DNAME 
FROM EMP INNER JOIN DEPT
         USING (DEPTNO);                -- 조인 참조 컬럼명

SELECT ENAME, DNAME 
FROM EMP NATURAL JOIN DEPT;
        
SELECT ENAME, DNAME 
FROM EMP INNER JOIN DEPT
         ON EMP.DEPTNO = DEPT.DEPTNO
WHERE ENAME='SCOTT';                    -- 검색 조건

-------------------------------------------------------------

DROP TABLE DEPT01;
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14)
);
INSERT INTO DEPT01 VALUES(10, 'ACCOUNTING');
INSERT INTO DEPT01 VALUES(20, 'RESEARCH');

SELECT * FROM DEPT01;

DROP TABLE DEPT02;
CREATE TABLE DEPT02( 
    DEPTNO NUMBER(2), 
    DNAME VARCHAR2(14)
); 

INSERT INTO DEPT02 VALUES (10, 'ACCOUNTING');
INSERT INTO DEPT02 VALUES (30, 'SALES'); 

SELECT * FROM DEPT01;
SELECT * FROM DEPT02;

SELECT *
FROM DEPT01 NATURAL JOIN  DEPT02;

SELECT *
FROM DEPT01 LEFT OUTER JOIN DEPT02
	ON DEPT01.DEPTNO = DEPT02.DEPTNO;
SELECT *
FROM DEPT01 RIGHT OUTER JOIN DEPT02
	ON DEPT01.DEPTNO = DEPT02.DEPTNO;
SELECT *
FROM DEPT01 FULL OUTER JOIN DEPT02
	ON DEPT01.DEPTNO = DEPT02.DEPTNO;

-- 서브쿼리
-- SCOTT과 같은 부서(부서번호)에서 근무하는 사원의 
-- 이름과 부서 번호를 출력하는 SQL 문을 작성해 보시오. (서브쿼리)
SELECT DEPTNO
FROM EMP
WHERE ENAME = 'SCOTT';   -- (결과) 20

SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'SCOTT');
                
-- SCOTT와 동일한 직급(JOB)을 가진 사원을 출력하는 SQL 문을 작성해 보시오. 
SELECT * FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'SCOTT');

SELECT * FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'SCOTT')
      AND ENAME <> 'SCOTT';

-- 사원테이블에서 최대급여금액와 최대급여를 받는 사원명을 출력
SELECT ENAME FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP);

-- 3000 이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원의
-- 사원명, 급여, 부서번호를 출력
SELECT DEPTNO FROM EMP WHERE SAL >= 3000;          -- (결과) 20/10/20
SELECT DISTINCT DEPTNO FROM EMP WHERE SAL >= 3000; -- (결과) 20/10

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (10, 20);

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DISTINCT DEPTNO FROM EMP WHERE SAL >= 3000);

-- 부서별로 가장 급여를 많이 받는 
-- 사원의 정보(사원 번호, 사원이름, 급여, 부서번호)를 출력하시오.(IN 연산자 이용)
SELECT EMPNO, ENAME, SAL , DEPTNO
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP 
              GROUP BY DEPTNO)
ORDER BY DEPTNO;

-- 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원(2850)보다
-- 더 많은 급여를 받는 사람의 이름, 급여를 출력
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);
             
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- 부서번호가 30번인 사원들의 급여 중 가장 작은 값(950)보다
-- 많은 급여를 받는 사원의 이름, 급여를 출력하는 
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);

SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30);

SELECT ENAME, SAL
FROM EMP
WHERE SAL > SOME (SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- 부서번호가 10인 부서명이 존재하는 사원을 출력하시오.
SELECT * FROM EMP
WHERE EXISTS( SELECT DNAME FROM DEPT WHERE DEPTNO = 10 );

-- 부서번호가 70인 부서명이 존재하는 사원을 출력하시오.
SELECT * FROM EMP
WHERE EXISTS( SELECT DNAME FROM DEPT WHERE DEPTNO = 70 );

SELECT * FROM EMP
WHERE 1=1;
SELECT * FROM EMP
WHERE 1=0;

SELECT ROWID, EMPNO, ENAME
FROM EMP;

-- 테이블 생성
DROP TABLE EMP01;
CREATE TABLE EMP01 (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL NUMBER(7,2)
);
CREATE TABLE DEPT01 (
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)   
);
DESC EMP01;
DESC DEPT01;
SELECT * FROM EMP01;
SELECT * FROM DEPT01;

CREATE TABLE EMP02
AS
SELECT * FROM EMP;

DESC EMP02;
SELECT * FROM EMP02;

CREATE TABLE EMP03
AS
SELECT EMPNO, ENAME FROM EMP;

CREATE TABLE EMP05
AS
SELECT * FROM EMP
WHERE DEPTNO = 10;

CREATE TABLE EMP06
AS
SELECT * FROM EMP
WHERE 1=0;

DESC EMP06;
SELECT * FROM EMP06;

SELECT * FROM EMP01;
ALTER TABLE EMP01 ADD(JOB VARCHAR2(9));
ALTER TABLE EMP01 DROP COLUMN JOB;
