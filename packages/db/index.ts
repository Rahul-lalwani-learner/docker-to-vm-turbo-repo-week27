import { PrismaClient } from "./generated/prisma/index.js";

/**
 * PRISMA CLIENT SINGLETON PATTERN
 * 
 * This implementation prevents multiple Prisma Client instances during development
 * hot reloading, which can cause:
 * - Connection pool exhaustion
 * - "Too many connections" errors
 * - Memory leaks
 * - Performance degradation
 * 
 * HOW IT WORKS:
 * 1. In development: Store the instance on globalThis to persist across hot reloads
 * 2. In production: Create a new instance normally (no hot reloading concerns)
 * 3. Use ?? operator to reuse existing instance or create new one
 * 
 * BENEFITS:
 * - ♻️  Reuses existing connections during hot reload
 * - 🚀 Better development performance
 * - 🔧 Prevents connection exhaustion
 * - ✅ Clean production builds
 */

// Singleton pattern to prevent multiple instances during hot reloading
const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

export const prismaClient = 
  globalForPrisma.prisma ?? 
  new PrismaClient({
    log: [], // Disable query logging for cleaner output
  });

// Store the instance globally in development to prevent re-creation
if (process.env.NODE_ENV !== 'production') {
  if (!globalForPrisma.prisma) {
    console.log("🔧 Creating new Prisma Client instance");
    globalForPrisma.prisma = prismaClient;
  } else {
    console.log("♻️  Reusing existing Prisma Client instance");
  }
}
