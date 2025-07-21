# PostgreSQL Docker Setup

A Docker-based PostgreSQL 15 setup optimized for development with Ukrainian locale support.

## 🚀 Features

- **PostgreSQL 15** with custom configuration
- **Ukrainian locale** support (uk_UA.UTF-8)
- **Custom user management** with proper permissions
- **Health checks** for container monitoring
- **Persistent data storage** with Docker volumes
- **Security configurations** via pg_hba.conf
- **Performance optimizations** in postgresql.conf

## 📁 Project Structure

```
postgres-docker/
├── conf/
│   ├── postgresql.conf    # PostgreSQL server configuration
│   └── pg_hba.conf       # Client authentication configuration
├── init-scripts/
│   └── 01-create-users.sql # Database initialization script
├── docker-compose.yml     # Docker Compose configuration
└── README.md             # This file
```

## 🔧 Configuration

### Database Settings
- **Database**: `davinci_projects`
- **User**: `davinci_user`
- **Port**: `5432` (localhost only)
- **Locale**: `uk_UA.UTF-8`
- **Timezone**: `Europe/Kiev`

### Extensions
- `pg_stat_statements` for performance monitoring

## 🚀 Quick Start

### Prerequisites
- Docker
- Docker Compose

### 1. Clone and Setup
```bash
git clone https://github.com/AratKruglik/postgres-db.git
cd postgres-db
```

### 2. Configure Password
Edit the password in both files:
- `docker-compose.yml` (line 11)
- `init-scripts/01-create-users.sql` (line 5)

Replace `your_secure_password_here` with a secure password.

### 3. Start PostgreSQL
```bash
docker-compose up -d
```

### 4. Verify Setup
```bash
# Check container status
docker-compose ps

# Check logs
docker-compose logs postgres

# Test connection
docker-compose exec postgres psql -U davinci_user -d davinci_projects
```

## 📊 Usage

### Connect to Database
```bash
# Using docker-compose
docker-compose exec postgres psql -U davinci_user -d davinci_projects

# Using local psql client
psql -h localhost -p 5432 -U davinci_user -d davinci_projects
```

### Database Operations
```sql
-- Check extensions
\dx

-- View database settings
SHOW timezone;
SHOW lc_collate;
SHOW lc_ctype;

-- Check user permissions
\du
```

## 🛠 Management Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Restart PostgreSQL
docker-compose restart postgres

# View logs
docker-compose logs -f postgres

# Backup database
docker-compose exec postgres pg_dump -U davinci_user davinci_projects > backup.sql

# Restore database
docker-compose exec -T postgres psql -U davinci_user -d davinci_projects < backup.sql
```

## 📈 Monitoring

### Health Check
The container includes built-in health checks:
```bash
docker-compose exec postgres pg_isready -U davinci_user -d davinci_projects
```

### Performance Monitoring
Access `pg_stat_statements` for query performance:
```sql
SELECT * FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 10;
```

## 🔒 Security Features

- **Local-only access**: PostgreSQL only accepts connections from localhost
- **Custom authentication**: Configured via pg_hba.conf
- **User isolation**: Dedicated database user with minimal required permissions
- **Secure defaults**: Custom PostgreSQL configuration with security optimizations

## 🐛 Troubleshooting

### Container won't start
```bash
# Check logs for errors
docker-compose logs postgres

# Verify configuration files
docker-compose config
```

### Connection issues
```bash
# Test container health
docker-compose exec postgres pg_isready

# Check if port is accessible
telnet localhost 5432
```

### Permission errors
```bash
# Reset permissions (recreates container)
docker-compose down -v
docker-compose up -d
```

## 📝 Customization

### Modify PostgreSQL Configuration
Edit `conf/postgresql.conf` and restart:
```bash
docker-compose restart postgres
```

### Add Initialization Scripts
Place `.sql` files in `init-scripts/` directory. They will be executed in alphabetical order on first startup.

### Change Database Settings
Modify `docker-compose.yml` environment variables and recreate container:
```bash
docker-compose down -v
docker-compose up -d
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🔗 Links

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [PostgreSQL Docker Image](https://hub.docker.com/_/postgres)
