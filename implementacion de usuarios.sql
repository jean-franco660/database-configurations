use TicTacToeDB;

CREATE USER 'admin1_tictactroe'@'%' IDENTIFIED BY 'contraseña_segura_admin1';

GRANT ALL PRIVILEGES ON TicTacTroeDB.* TO 'admin1_tictactroe'@'%';

CREATE USER 'dev1_tictactoe'@'%' IDENTIFIED BY '123456789';
CREATE USER 'dev2_tictactoe'@'%' IDENTIFIED BY '123456789';
CREATE USER 'dev3_tictactoe'@'%' IDENTIFIED BY '123456789';

GRANT SELECT, INSERT, UPDATE, DELETE ON TicTacTroeDB.* TO 'dev1_tictactroe'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicTacToeDB.* TO 'dev2_tictactoe'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicTacToeDB.* TO 'dev3_tictactoe'@'%';
FLUSH PRIVILEGES;
